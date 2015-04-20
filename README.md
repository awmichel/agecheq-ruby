# AgeCheq API Client for Ruby

This is a simple [HTTParty](http://johnnunemaker.com/httparty/) wrapper around the [AgeCheq](http://www.agecheq.com/) API.

## Installation

Add `agecheq` to your Gemfile.

```ruby
gem 'agecheq'
```

## Usage

You must first configure the gem with your developer key and application id. Both can be obtained from the [AgeCheq Developer Dashboard](http://developer.agecheq.com/).

```ruby
AgeCheq.configure do |config|
  config.api_key = "ABCD"
  config.application_id = "XYZ"
end
```

### Status Check

Check the status of an AgeCheq PIN and your application using:

```ruby
AgeCheq::Child.check('AGECHEQ_PIN')
OR
child = AgeCheq::Child.new('AGECHEQ_PIN')
child.status
```

### Associate Data

Associate data with an AgeCheq PIN and your application using:

```ruby
AgeCheq::Child.associate('AGECHEQ_PIN', 'DATA')
OR
child = AgeCheq::Child.new('AGECHEQ_PIN')
child.associate('DATA')
```

## Testing

Testing is done with RSpec and executed using `bundle exec rspec`.
