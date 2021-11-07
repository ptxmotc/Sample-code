use base64;
use ring::hmac::{sign, Key, HMAC_SHA1_FOR_LEGACY_USE_ONLY};

pub fn signature(key: &[u8], body: &[u8]) -> String {
    let key = Key::new(HMAC_SHA1_FOR_LEGACY_USE_ONLY, key);

    let tag = sign(&key, body);

    base64::encode(tag.as_ref())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_signature() {
        assert_eq!(
            signature(b"secret_key", "bodystring".as_bytes()),
            "lwSWI7Dl0gv2vrUxPYBgDj1qvlY="
        )
    }
}
