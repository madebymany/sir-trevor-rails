<!-- @format -->

# Sir Trevor Rails

A Rails gem for integrating Sir Trevor JS into your Rails application.

## What's new in v0.7

- **Rails 8 support** — verified via CI across Rails 5.2 through 8.0.
- **Minimum Rails is now 5.2** — apps on Rails 4 or earlier should stay on v0.6.3.
- **Minimum Ruby is now 2.7.**
- **Security hardening** — `sir_trevor_markdown` output now passes through Rails' `sanitize` helper. If your content uses tags beyond the standard Markdown set (e.g. `<sup>`), extend the allowlist in an initializer:
  ```ruby
  Rails.application.config.action_view.sanitized_allowed_tags = Rails.application.config.action_view.sanitized_allowed_tags.to_a + ['sup']
  ```
- **Upgrade note** — if you relied on arbitrary HTML passing through `sir_trevor_markdown` unfiltered, review your block templates after upgrading. See the [CHANGELOG](CHANGELOG.md) for full details.

## Upgrade guide to v0.6.0

There is a breaking change which needs to be applied if you've defined custom ruby blocks.

Create an initializer `config/initializers/sir_trevor_rails.rb`

Add your custom block types in the initializer:

```ruby
class SirTrevorRails::Block
  def self.custom_block_types
    # Type should be string based and prefix of your class name.
    ["Custom"] # Would relate to CustomBlock
  end
end
```

## Upgrade guide from v0.4.0-rc.1

Version 0.4.0 represents a major refactor and contains significant API changes.

- The SirTrevor gem has been renamed from `sir-trevor-rails` to `sir_trevor_rails` you will need to update your Gemfile.
- There are no more form helpers or view helpers so relace `f.sir_trevor_text_area :content` with `f.text_area :content`.
- SirTrevor JS and it's dependencies are no longer bundled with the gem and need to be downloaded and installed manually or with bower. [See the SirTrevor JS repo for more](https://github.com/madebymany/sir-trevor-js#plain-js).
- In your model, register your SirTrevor content like this `sir_trevor_content :content` where `:content` is the name of the field on your where you store SirTrevor content.
- In your views, you no longer need to use the `render_sir_trevor` helper. Instead, simply render your content like this `<%= render @item.content %>`

## Usage

Add Sir Trevor to your Gemfile

```ruby
gem 'sir_trevor_rails'
```

```bash
bundle install
```

Include Sir Trevor JS in your project following the instructions set out [here](http://madebymany.github.io/sir-trevor-js/docs.html)

## Generators: Views

Grab all of the default block type partials by running the following generator command:

```bash
rails g sir_trevor_rails:views
```

This will copy all of the SirTrevor block partials into `app/views/sir_trevor/blocks/`

## Rendering

In your models pass the attribute name of your Sir Trevor content to `sir_trevor_content`

```ruby
sir_trevor_content :content
```

In your view files, call render to display the Sir Trevor content

```ruby
<%= render @item.content %>
```

## Handling image uploads

We don't provide a default image uploader out of the box, because everyone will have different requirements. To see an example of an image uploader, please refer to [this gist](https://gist.github.com/cjbell/7091537).

## Handling markdown

Use the `sir_trevor_markdown` method in your custom block partials to correctly parse the markdown in a block

## Querying the block content

Use the following methods to query the Sir Trevor content

```ruby
@item.content.has_block_of_type?(:image)
```

Does this content have an image block?

```ruby
@item.content.first_block_of_type(:video)
```

Return the first video block in the content

## Add custom block types with custom methods

Create an initializer `config/initializers/sir_trevor_rails.rb`

Add your custom block types in the initializer:

```ruby
class SirTrevorRails::Block
  def self.custom_block_types
    # Type should be string based and prefix of your class name which would be for the following.
    # TextBlock, HeadingBlock, CustomBlock
    ["Text", "Heading", "Custom"]
  end
end
```

## Add custom methods for block content

Create an initializer `config/initializers/sir_trevor_rails.rb`

Write your method in the initializer:

```ruby
class SirTrevorRails::BlockArray
  def your_custom_method_here
    # some code
  end
end
```

Call your method on the ST content

```ruby
@item.content.your_custom_method
```

## Generators: Blocks

Run the blocks generator to create templates for your custom blocks

```bash
rails g sir_trevor_rails:block my_custom_block
```

This will generate an html file for rendering the block, a javascript file for the editor and a ruby block class.

## Block Classes

Ruby block classes can be used like decorators for the block content. See the [tweet block class](https://github.com/madebymany/sir-trevor-rails/blob/redesign-gem/lib/sir_trevor_rails/blocks/tweet_block.rb) for an example

## Requirements

- Rails 3.x/4.x/5.x/6.x

## To do

- Add tests

## Licence

Sir Trevor Rails is released under the [MIT Licence](MIT-LICENSE)

## Changelog

See the [CHANGELOG](CHANGELOG)
