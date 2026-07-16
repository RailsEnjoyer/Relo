# Tech Debt

## Pre-MVP

- [ ] Add listing filters for all `RelocationPlan` fields on the listings page
- [ ] Add setup/onboarding docs (README section or `SETUP.md`): how to run the app locally, including the mandatory one-time `location_seeds.rb` run before `db:seed` (states/cities dataset that `relocation_plan_seeds.rb` depends on)

## Testing

- [ ] Write specs for models and services
- [ ] Add shared examples (reusable groups of examples for common behavior)

## Validations

- [ ] `Amenity`: presence and uniqueness of `title`
- [x] `ListingAmenity`: uniqueness of `[listing_id, amenity_id]` pair (both model validation and DB-level unique index)

## Refactoring

- [x] Move listing filters from frontend to backend

## Security

- [ ] `Listing#filter_by_title`: wrap user input with `sanitize_sql_like` to escape `%` and `_` wildcards in ILIKE search
