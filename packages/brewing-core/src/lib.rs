pub fn gravity_points(ppg: f64, weight_lb: f64, efficiency: f64, volume_gal: f64) -> f64 {
    (ppg * weight_lb * efficiency) / volume_gal
}

pub fn original_gravity(points: f64) -> f64 {
    1.0 + (points / 1000.0)
}

pub fn abv(og: f64, fg: f64) -> f64 {
    (og - fg) * 131.25
}

#[cfg(test)]
mod tests {
    use super::{abv, gravity_points, original_gravity};

    #[test]
    fn calculates_gravity_points() {
        let points = gravity_points(36.0, 10.0, 0.72, 5.5);
        assert!((points - 47.127).abs() < 0.01);
    }

    #[test]
    fn calculates_original_gravity() {
        let og = original_gravity(50.0);
        assert!((og - 1.050).abs() < 0.0001);
    }

    #[test]
    fn calculates_abv() {
        let value = abv(1.050, 1.010);
        assert!((value - 5.25).abs() < 0.01);
    }
}

