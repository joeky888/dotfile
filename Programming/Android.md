Use dollar sign as the selector
=====
```java
public abstract class BaseFragment extends Fragment {
    public final <E extends View> E $(int id) {
        return (E) rootView.findViewById(id);
    }
}

// Usage $(R.id.textview).setText("hi")
```
