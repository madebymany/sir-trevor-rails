# Sir Trevor Rails

A Rails gem for integrating the Sir Trevor JS into your Rails 3.x application. 

# Usage

Add Sir Trevor to your Gemfile 

```ruby
gem 'sir-trevor-rails'
```

```bash
bundle install 
```

Require SirTrevor in your `application_controller.rb`

```ruby
require 'sir-trevor-rails'
```

Include Sir Trevor in your `application.css` file

```css
*= require sir-trevor
```

Include Sir Trevor in your `application.js` file

```js
//= require sir-trevor
```

In your view file for your editable content (must be a 'text' field as we store the JSON here) here we have a field called 'content'

```ruby
f.sir_trevor_text_area :content
```

And instantiate a new `SirTrevor.Editor` instance in your Javascript. 

```javascript
$(function(){
  var editor = new SirTrevor.Editor({ el: $('.sir-trevor-area') });
});
```

Or for multiple instances:

```javascript
$(function(){
  var instances = $('.sir-trevor-area'),
      l = instances.length, instance;
  
  while (l--) {
    instance = $(instances[l]);
    new SirTrevor.Editor({ el: instance });
  }
  
});
```

To render your content (in your view file)

```ruby
<%= render_sir_trevor(post.content) %>
```

# Generators

## Views

To grab all of the default block type partials into your application run the following generator command:

```bash
rails g sir_trevor:views
```

This will copy all of the SirTrevor block partials into `app/views/sir-trevor/blocks/`

# Handling image uploads

We don't provide a default image uploader out of the box, because everyone will have different requirements.

# Helper methods

**`render_sir_trevor`**

Parses the blocks JSON content, loops through each piece of block content and render the appropriate partial for the block. 

**`render_sir_trevor_image`**

Returns the first available SirTrevor image from the supplied JSON.

**`sir_trevor_image_tag`**

Returns an image tag from a SirTrevor Image block

**`pluck_sir_trevor_type` (Private)**

Get the first instance of a specified SirTrevor block type from the supplied JSON

# Requirements

- Rails 3.x  
- jQuery
- Underscore.js (bundled)

# To do

- Add tests 

# Licence

Sir Trevor Rails is released under the MIT Licence

http://www.opensource.org/licenses/MIT
