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

# Requirements

- Rails 3.x  
- jQuery
- Underscore.js (bundled)