Add base model like ID, CreatedAt, UpdatedAt and DeletedAt
=====
```go
type BaseModel struct {
	ID        int64      `pg:",pk" gorm:"primarykey"`
	CreatedAt time.Time  `pg:"default:now()"`
	UpdatedAt time.Time  `pg:"default:now()"`
	DeletedAt *time.Time `pg:",soft_delete" gorm:"index"`
}

type User struct {
	BaseModel
	Name   string
	Emails []string
}

func createTable(db *pg.DB) error {
	// Auto update the updated_at column
	updateTrigger := `CREATE OR REPLACE FUNCTION update_trigger()
	RETURNS TRIGGER AS $$
	BEGIN
	   IF row(NEW.*) IS DISTINCT FROM row(OLD.*) THEN
	      NEW.updated_at = now();
	      RETURN NEW;
	   ELSE
	      RETURN OLD;
	   END IF;
	END;
	$$ language 'plpgsql'`

        if _, err := db.Exec(updateTrigger); err != nil {
		return err
	}

	if err := db.Model((*User)(nil)).CreateTable(&orm.CreateTableOptions{
		Temp:        true,
		IfNotExists: true,
	}); err != nil {
            return err
        }

        if _, err := db.Exec(fmt.Sprintf(`DROP TRIGGER IF EXISTS %s on %s;`, "update_user", "users")); err != nil {
                return err
        }

	// Create a update function trigger "update_user" on the "users" table
	if _, err := db.Exec(fmt.Sprintf(`CREATE TRIGGER %s BEFORE UPDATE ON %s FOR EACH ROW EXECUTE PROCEDURE update_trigger()`, "update_user", "users")); err != nil {
		return err
	}

        return nil
}
```

Debug query with SQL statements and file:line
=====
```go
import (
	"context"
	"fmt"
	"runtime"
	"strings"

	"github.com/go-pg/pg/v10"
	"github.com/go-pg/pg/v10/orm"
	"github.com/mattn/go-colorable"
)

type PGDebug struct {
	Logger   LoggerInterface
	Colorful bool
}

func (p *PGDebug) BeforeQuery(ctx context.Context, evt *pg.QueryEvent) (context.Context, error) {
	colorReset := "\033[0m"

	colorRed := "\033[31m"
	colorGreen := "\033[32m"
	colorYellow := "\033[33m"
	colorBlue := "\033[34m"
	colorMagenta := "\033[35m"
	colorCyan := "\033[36m"
	colorWhite := "\033[37m"

	_ = colorRed
	_ = colorGreen
	_ = colorYellow
	_ = colorBlue
	_ = colorMagenta
	_ = colorCyan
	_ = colorWhite

	var buffer string
	for i := 2; i < 15; i++ {
		_, file, line, ok := runtime.Caller(i)
		if ok && (!strings.Contains(file, "github.com/go-pg/pg/") || strings.HasSuffix(file, "_test.go")) {
			var buf = fmt.Sprintf(" %s:%d ", file, line)
			if p.Colorful {
				buf = colorGreen + buf
			}
			buffer += buf
			break
		}
	}

	q, err := evt.FormattedQuery()
	if err != nil {
		return nil, err
	}

	if evt.Err != nil {
		var buf = fmt.Sprintf("%s executing a query:\n%s\n", evt.Err, q)
		if p.Colorful {
			buf = colorRed + buf
		}
		buffer += buf
	} else {
		var buf = string(q)
		if p.Colorful {
			buf = colorMagenta + buf
		}
		buffer += buf
	}

	buffer += colorReset + "\n"
	p.Logger.Printf(buffer)
	return ctx, nil
}

func (*PGDebug) AfterQuery(ctx context.Context, evt *pg.QueryEvent) error {
	return nil
}

type DefaultPGLogger struct{}

func (*DefaultPGLogger) Printf(strFormat string, strs ...interface{}) {
	stdout := colorable.NewColorableStdout()
	fmt.Fprintf(stdout, strFormat, strs...)
}

func main() {
	db := pg.Connect(&pg.Options{
		Addr:     ":5432",
		User:     "good",
		Password: "good",
		Database: "good",
	})
	db.AddQueryHook(&PGDebug{
		Logger:   &DefaultPGLogger{},
		Colorful: true,
	})
}

```
