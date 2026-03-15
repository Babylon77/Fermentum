use brewing_core::{abv, original_gravity};

#[test]
fn smoke_test_public_api() {
    let og = original_gravity(48.0);
    let result = abv(og, 1.010);

    assert!(result > 4.0);
}

