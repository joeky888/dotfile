Observable
=====
* Very much like an in-memory MessageQueue client, use cases are
  * User keeps input, like keydown or mouse move
  * Large file streaming
  * Socket/WebSocket
  * Array filtering
* Data pipeline
  * Array of input data -> Map/Transform/Reduce/Process -> Filter -> Observer
* Genres of observables
  * Unicasting observables(單播) - Only one observable will get the data
  * Broadcasting observables(多播) - All observables will get the same data
  * Connectable observables(多播，連接後開始處理) - Broadcasts to observables until they call Connect(), this prevents the last observable from lossing the beginning data at start
  * Buffered observables(緩衝後一次處理) - Broadcasts to observables until the queue is full or time is up
* Creating an unicasting observable (單播) which is also called Hot Observables
  * Create() - Data source is a []rxgo.Producer
  * Just() - Data source is from function args - e.g. rxgo.Just(1, 2, 3, 4, 5)()
  * FromChannel() - Data source is a existing golang channel
  * Interval() - Data source is current time with an interval, and is unstoppable-increasing
  * Range() - Data source is form a range of upper and lower bonds - e.g. rxgo.Range(0, 100)
  * Repeat() - Repeat a data source from an existing observable - e.g. rxgo.Just(1, 2, 3)().Repeat(/*time*/)
  * Start() - Data source is a []rxgo.Supplier
* Creating broadcasting observables (多播) which is also called Cold Observables
  * Defer() - Like Create(), but all observerbles will get the same data
* Creating connectable observables (多播，連接後開始處理) which is also called Cold Observables
  * Add rxgo.WithPublishStrategy() to the existing observable creater
  * Set up all observerables
  * observable.Connect(context.Background()) # This makes all observables start working
* Creating buffered observables
  * BufferWithCount(3) - Broadcasting to observables when queue is full (3 messages are delivered in this case)
  * BufferWithTime(3 * time.Second) - Broadcasting to observables when a given interval is ticked
  * BufferWithTimeOrCount(3 * time.Second, 3) - Combines the the functions of BufferWithCount() and BufferWithTime()
