# NameRemaker

Provides all possible combinations for a full name where the first name is always present along with a last name.
It also filters all combinations for given maximum lenth.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'name_remaker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install remaker

## Usage

  #### All combinations

    remaker = NameRemaker.remake first_names: "Tom Mark Antonio", last_names:  "Smith Grant Cruise"


    remaker.all
      # => [NameRemaker::NameInstance]

    remaker.all.map(&:full_name)
      #  =>  ["Tom Mark Antonio Smith Grant Cruise",
              "Tom Mark Antonio Smith Grant",
              "Tom Mark Antonio Smith Cruise",
              "Tom Mark Antonio Grant Cruise",
              "Tom Mark Smith Grant Cruise",
              "Tom Antonio Smith Grant Cruise",
              "Tom Mark Antonio Smith",
              "Tom Mark Antonio Grant",
              "Tom Mark Antonio Cruise",
              "Tom Mark Smith Grant",
              "Tom Mark Smith Cruise",
              "Tom Mark Grant Cruise",
              "Tom Antonio Smith Grant",
              "Tom Antonio Smith Cruise",
              "Tom Antonio Grant Cruise",
              "Tom Smith Grant Cruise",
              "Tom Mark Smith",
              "Tom Mark Grant",
              "Tom Mark Cruise",
              "Tom Antonio Smith",
              "Tom Antonio Grant",
              "Tom Antonio Cruise",
              "Tom Smith Grant",
              "Tom Smith Cruise",
              "Tom Grant Cruise",
              "Tom Smith",
              "Tom Grant",
              "Tom Cruise"]


  #### All combinations with a maximum full name length of 15

    remaker.max_length_of(15)
      # => [NameRemaker::NameInstance]

    remaker.max_length_of(15).map(&:full_name)
      # => ["Tom Mark Antonio Smith Grant Cruise",
            "Tom Antonio Smith Grant Cruise",
            "Tom Mark Antonio Smith Cruise",
            "Tom Mark Antonio Grant Cruise",
            "Tom Mark Antonio Smith Grant",
            "Tom Mark Smith Grant Cruise",
            "Tom Antonio Grant Cruise",
            "Tom Antonio Smith Cruise",
            "Tom Antonio Smith Grant",
            "Tom Mark Antonio Cruise",
            "Tom Mark Antonio Grant",
            "Tom Mark Antonio Smith",
            "Tom Smith Grant Cruise",
            "Tom Mark Smith Cruise",
            "Tom Mark Grant Cruise",
            "Tom Mark Smith Grant",
            "Tom Antonio Cruise",
            "Tom Antonio Grant",
            "Tom Antonio Smith",
            "Tom Smith Cruise",
            "Tom Grant Cruise",
            "Tom Mark Cruise",
            "Tom Smith Grant",
            "Tom Mark Grant",
            "Tom Mark Smith",
            "Tom Cruise",
            "Tom Smith",
            "Tom Grant"]

  #### All combinations with first names separated from the last names with a given separator (', ' given)

    remaker.all.map {|combination| combination.full_name(separator: ', ') }
      #  =>  ["Tom Mark Antonio, Smith Grant Cruise",
              "Tom Mark Antonio, Smith Grant",
              "Tom Mark Antonio, Smith Cruise",
              "Tom Mark Antonio, Grant Cruise",
              "Tom Mark, Smith Grant Cruise",
              "Tom Antonio, Smith Grant Cruise",
              "Tom Mark Antonio, Smith",
              "Tom Mark Antonio, Grant",
              "Tom Mark Antonio, Cruise",
              "Tom Mark, Smith Grant",
              "Tom Mark, Smith Cruise",
              "Tom Mark, Grant Cruise",
              "Tom Antonio, Smith Grant",
              "Tom Antonio, Smith Cruise",
              "Tom Antonio, Grant Cruise",
              "Tom, Smith Grant Cruise",
              "Tom Mark, Smith",
              "Tom Mark, Grant",
              "Tom Mark, Cruise",
              "Tom Antonio, Smith",
              "Tom Antonio, Grant",
              "Tom Antonio, Cruise",
              "Tom, Smith Grant",
              "Tom, Smith Cruise",
              "Tom, Grant Cruise",
              "Tom, Smith",
              "Tom, Grant",
              "Tom, Cruise"]

  #### All combinations with first names separated from the last names with a given separator (', ' given) and reversed full name option set

    remaker.all.map {|combination| combination.full_name(separator: ', ', reversed: true) }
      #  =>  ["Smith Grant Cruise, Tom Mark Antonio",
              "Smith Grant, Tom Mark Antonio",
              "Smith Cruise, Tom Mark Antonio",
              "Grant Cruise, Tom Mark Antonio",
              "Smith Grant Cruise, Tom Mark",
              "Smith Grant Cruise, Tom Antonio",
              "Smith, Tom Mark Antonio",
              "Grant, Tom Mark Antonio",
              "Cruise, Tom Mark Antonio",
              "Smith Grant, Tom Mark",
              "Smith Cruise, Tom Mark",
              "Grant Cruise, Tom Mark",
              "Smith Grant, Tom Antonio",
              "Smith Cruise, Tom Antonio",
              "Grant Cruise, Tom Antonio",
              "Smith Grant Cruise, Tom",
              "Smith, Tom Mark",
              "Grant, Tom Mark",
              "Cruise, Tom Mark",
              "Smith, Tom Antonio",
              "Grant, Tom Antonio",
              "Cruise, Tom Antonio",
              "Smith Grant, Tom",
              "Smith Cruise, Tom",
              "Grant Cruise, Tom",
              "Smith, Tom",
              "Grant, Tom",
              "Cruise, Tom"]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/frankapimenta/name_remaker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Name project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/frankapimenta/name_remaker/blob/master/CODE_OF_CONDUCT.md).
