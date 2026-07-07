# Tech Debt

## Testing

- [ ] Write specs for models and services
- [ ] Add shared examples (reusable groups of examples for common behavior)

## Validations

- [ ] `Amenity`: presence and uniqueness of `title`
- [x] `ListingAmenity`: uniqueness of `[listing_id, amenity_id]` pair (both model validation and DB-level unique index)
