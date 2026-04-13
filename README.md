# quadPatPad
## [GameMaker]  Shader for pushing vertices to add padding around sprite.
This asset pushes vertices to add padding around drawn sprites, so there is empty space around sprite for effects such as outlines.
The examples in asset only uses it for outlines, but you can modify it for your needs, replace the effect in shader with something else for example.

Test on itchio : https://terohannula.itch.io/quadPatPad

### Using
​Following uses default settings, adds 1px padding and 1px outline:

```gml
quadPatPadSet();
// Draw stuff in-between, like `draw_self()`
quadPatPadEnd();
```
You do not need to call End in same event. Note that the asset requires and will use "shader_enable_corner_id(true)", it will break if you set it otherwise.

You may pass optional parameters with struct.

```gml
​quadPatPadSet({
​    // Padding related.
    debug : [ 1, 0, 0, 0.5 ], // Visualized debug color.
​    padding : 4, // How far vertices are pushed.
​    
​    // Outline related.
​    offsets : [ ], // Positions for outline neighbour checks.
​    threshold : 0.5, // What is considered empty pixel for outline.
​    outline : [ 0, 0, 0, 1 ] // Color of outline.​
​}); 
​// Draw stuff in-between, like `draw_self()` 
​quadPatPadEnd();
```
