# Tech Debt

## Pre-MVP

- [ ] Add listing filters for all `RelocationPlan` fields on the listings page

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
