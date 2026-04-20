<!-- @format -->

# Changelog

## v0.6.3 — 2022-03-29

- Update to twitter-text 2+
- Allow support for Rails 7

## v0.6.2 — 2020-10-20

- Allow superscript tags

## v0.6.1 — 2020-02-12

- Rails 6 support

## v0.6.0 — 2019-02-19

- Added `custom_block_types` to improve block class lookup performance

## v0.4.0 — 2014-05-20

- Renamed gem to `sir_trevor_rails` (was `sir-trevor-rails`)
- Removed sir trevor JS and all its dependencies (install manually or via bower)
- Removed all view helpers except `sir_trevor_markdown` (`render_sir_trevor`, `render_sir_trevor_block`, `render_sir_trevor_image`, `sir_trevor_image_tag`, `parse_sir_trevor` are gone)
- Removed the form helper (`sir_trevor_text_area`)
- Added `has_sir_trevor_content.rb` as a concern for models with ST content
- Removed jQuery Rails dependency
- Use view resolvers and `to_partial_path` to render ST content
- Added block array class and block classes
- Added lookup methods on the block array
