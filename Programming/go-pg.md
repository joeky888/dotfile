Add base model like ID, CreatedAt, UpdatedAt and DeletedAt
=====
```go
type BaseModel struct {
	ID        int64     `pg:",pk"`
	CreatedAt time.Time `pg:"default:now()"`
	UpdatedAt time.Time
	DeletedAt *time.Time `pg:",soft_delete"`
}

func (m *BaseModel) BeforeInsert(ctx context.Context) (context.Context, error) {
	now := time.Now()
	if m.CreatedAt.IsZero() {
		m.CreatedAt = now
	}
	if m.UpdatedAt.IsZero() {
		m.UpdatedAt = now
	}
	return ctx, nil
}

func (m *BaseModel) BeforeUpdate(ctx context.Context) (context.Context, error) {
	m.UpdatedAt = time.Now()
	return ctx, nil
}

type User struct {
	BaseModel
	Name   string
	Emails []string
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
