# What are Mixins?

Mixins are a way of reusing a class's code in multiple class hierarchies. They provide a mechanism to share code between classes without using traditional inheritance.

## Key Concepts

- **Code Reuse**: Mixins allow you to reuse code across different class hierarchies
- **Multiple Inheritance**: Dart doesn't support multiple inheritance, but mixins provide similar functionality
- **Composition over Inheritance**: Mixins promote composition patterns

## Benefits of Mixins

1. **Avoid Code Duplication**: Share common functionality across unrelated classes
2. **Flexible Design**: Mix and match behaviors as needed
3. **Clean Architecture**: Keep classes focused on their primary responsibility
4. **Easy Maintenance**: Changes to mixin affect all classes that use it

## When to Use Mixins

- When multiple classes need the same functionality
- When you want to add optional behaviors to classes
- When inheritance hierarchy becomes too complex
- When you need to combine multiple behaviors

## Mixin vs Class vs Interface

| Feature | Class | Mixin | Interface |
|---------|-------|-------|-----------|
| Instantiation | ✅ Yes | ❌ No | ❌ No |
| Implementation | ✅ Yes | ✅ Yes | ❌ No |
| Multiple Usage | ❌ Single inheritance | ✅ Multiple mixins | ✅ Multiple interfaces |
| Constructor | ✅ Yes | ❌ No | ❌ No |