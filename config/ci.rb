# frozen_string_literal: true

# Run using bin/ci

CI.run do
  step 'Setup', 'bin/setup --skip-server'

  step 'Quality: Ruby lint', 'bin/rubocop'
  step 'Quality: Zeitwerk', 'RAILS_ENV=test bin/rails zeitwerk:check'

  step 'Security: Gem audit', 'bin/bundler-audit check --update'
  step 'Security: Importmap vulnerability audit', 'bin/importmap audit'
  step 'Security: Brakeman code analysis', 'bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error'
  step 'Tests: Prepare test DB', 'RAILS_ENV=test bin/rails db:test:prepare'
  step 'Tests: RSpec', 'bin/rspec spec'
  step 'Tests: Seeds', 'env RAILS_ENV=test bin/rails db:seed:replant'

  if Dir.glob('test/system/**/*_test.rb').any?
    step 'Tests: System', 'RAILS_ENV=test bin/rails test:system'
  end
end
