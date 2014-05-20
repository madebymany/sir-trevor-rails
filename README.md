# Sir Trevor Rails

A Rails gem for integrating Sir Trevor JS into your Rails 3/4 application.

## Upgrade guide from v0.4.0-rc.1

Version 0.4.0 represents a major refactor and contains significant API changes.

* The SirTrevor gem has been renamed from ``sir-trevor-rails`` to ``sir_trevor_rails`` you will need to update your Gemfile.
* There are no more form helpers or view helpers so relace ``f.sir_trevor_text_area :content`` with ``f.text_area :content``.
* SirTrevor JS and it's dependencies are no longer bundled with the gem and need to be downloaded and installed manually or with bower. [See the SirTrevor JS repo for more](https://github.com/madebymany/sir-trevor-js#plain-js).
* In your model, register your SirTrevor content like this ``sir_trevor_content :content`` where ``:content`` is the name of the field on your where you store SirTrevor content.
* In your views, you no longer need to use the ``render_sir_trevor`` helper. Instead, simply render your content like this ``<%= render @item.content %>``

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

We don't provide a default image uploader out of the box, because everyone will have different requirements. To see an example of an image uploader, please refer to our Rails examples in the [Sir Trevor JS repository](https://github.com/madebymany/sir-trevor-js/tree/master/examples/rails/image-uploader).

## Handling markdown

Use the ``sir_trevor_markdown`` method in your custom block partials to correctly parse the markdown in a block

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

## Add custom methods for block content

Create an initializer ``config/initializers/sir_trevor_rails.rb``

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


- Rails 3.x/4.x

## To do

- Add tests

## Licence

Sir Trevor Rails is released under the [MIT Licence](MIT-LICENSE)

## Changelog

See the [CHANGELOG](CHANGELOG)
