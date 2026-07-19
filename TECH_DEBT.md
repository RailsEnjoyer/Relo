# Tech Debt

## Pre-MVP

- [ ] Add listing filters for all `RelocationPlan` fields on the listings page
- [ ] Add setup/onboarding docs (README section or `SETUP.md`): how to run the app locally, including the mandatory one-time `location_seeds.rb` run before `db:seed` (states/cities dataset that `relocation_plan_seeds.rb` depends on)

## Testing

- [ ] Write specs for models and services
- [ ] Add shared examples

## Validations

- [ ] `Amenity`: presence and uniqueness of `title`
- [x] `ListingAmenity`: uniqueness of `[listing_id, amenity_id]` pair (both model validation and DB-level unique index)

## Refactoring

- [x] Move listing filters from frontend to backend
- [ ] Move all hardcoded strings (validation messages, error responses, etc.) to locale files (`config/locales/*.yml`)
- [ ] Replace ad-hoc success/error rendering in controllers with `ApplicationController#handle_write_action` where applicable
- [ ] Rewrite `Listings::MatchCalculator` — refactor scoring/penalty logic, address N+1 in location matching (see chain calls in `match_neighborhood_level`), extract magic numbers, reconsider score/penalty interaction

## Security

- [ ] `Listing#filter_by_title`: wrap user input with `sanitize_sql_like` to escape `%` and `_` wildcards in ILIKE search
