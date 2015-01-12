# Sir Trevor Rails

A set of Rails Helpers for Sir Trevor JS.

# Usage

REWRITE REQUIRED.

# Requirements

- Rails 3.x
- jQuery
- (Eventable)[https://github.com/madebymany/eventable]
- (Underscore)[https://github.com/jashkenas/underscore]
- (Sir Trevor JS)[https://github.com/madebymany/sir-trevor-js]

# Generators

## Views

To grab all of the default block type partials into your application run the following generator command:

```bash
rails g sir_trevor:views
```

This will copy all of the SirTrevor block partials into `app/views/sir-trevor/blocks/`

# Handling image uploads

We don't provide a default image uploader out of the box, because everyone will have different requirements. Until we provide a full example project, have a look at [this gist](https://gist.github.com/cjbell/7091537) which allows uploads using CarrierWave and Fog (for S3). 

# Helper methods

**`render_sir_trevor`**

Parses the blocks JSON content, loops through each piece of block content and render the appropriate partial for the block.

**`render_sir_trevor_image`**

Returns the first available SirTrevor image from the supplied JSON.

**`sir_trevor_image_tag`**

Returns an image tag from a SirTrevor Image block

**`pluck_sir_trevor_type`**

Get the first instance of a specified SirTrevor block type from the supplied JSON

# To do

- Add tests

# Licence

Sir Trevor Rails is released under the MIT Licence

http://www.opensource.org/licenses/MIT
