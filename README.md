# Sir Trevor Rails

A Rails gem for integrating Sir Trevor JS into your Rails 3.x application.

# Usage

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
rails g sir_trevor:views
```

This will copy all of the SirTrevor block partials into `app/views/sir_trevor/blocks/`

## Rendering

In your models pass the attribute name of your Sir Trevor content to `sir_trevor_content`

```ruby
sir_trevor_content :content
```

In your view files, call render to display the Sir Trevor content

```ruby
<%= render @item.contemt %>
```

There's an example Rails 3.2.7 project with all of this already done in the [Sir Trevor JS repository](https://github.com/madebymany/sir-trevor-js/tree/master/examples/rails/sir-trevor-example).

## Handling image uploads

We don't provide a default image uploader out of the box, because everyone will have different requirements. To see an example of an image uploader, please refer to our Rails examples in the [Sir Trevor JS repository](https://github.com/madebymany/sir-trevor-js/tree/master/examples/rails/image-uploader).

## Handling markdown

**`sir_trevor_markdown`**

Use the `sir_trevor_markdown`method in your custom block partials to correctly parse the markdown in a block

## Querying the block content

Use the following methods to query the Sir Trevor content

**`@item.contemt.has_block_of_type?(:image)`**

Does this content have an image block?

**`@item.contemt.first_block_of_type(:video)`**

Return the first video block in the content

## Generators: Blocks

Run the blocks generator to create templates for your custom blocks

```bash
rails g sir_trevor:blocks my_custom_block
```

This will generate an html file for rendering the block, a javascript file for the editor and a ruby block class.

## Block Classes

Ruby block classes can be used like decorators for the block content. See the [tweet block class](https://github.com/madebymany/sir-trevor-rails/blob/redesign-gem/lib/sir_trevor_rails/blocks/tweet_block.rb) for an example

## Requirements

- Rails 3.x

# To do

- Add tests

# Licence

Sir Trevor Rails is released under the MIT Licence

http://www.opensource.org/licenses/MIT
