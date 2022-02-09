use std::fmt::{Display, Formatter, Result};

#[derive(Debug)]
pub struct Authorization {
    username: String,
    algorithm: String,
    headers: String,
    signature: String,
}

impl Authorization {
    pub fn new(username: &str, signature: &str) -> Self {
        Self {
            username: username.to_string(),
            algorithm: String::from("hmac-sha1"),
            headers: String::from("x-date"),
            signature: signature.to_string(),
        }
    }
}

impl Display for Authorization {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result {
        write!(
            f,
            r#"hmac username="{}", algorithm="{}", headers="{}", signature="{}""#,
            self.username, self.algorithm, self.headers, self.signature,
        )
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_to_string() {
        assert_eq!(
            Authorization::new("username", "signature").to_string(),
            r#"hmac username="username", algorithm="hmac-sha1", headers="x-date", signature="signature""#
        );
    }
}
