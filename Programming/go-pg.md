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
```
