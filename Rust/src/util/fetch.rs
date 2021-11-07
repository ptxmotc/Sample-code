use exitfailure::ExitFailure;
use reqwest::{header::HeaderMap, Client};
use serde::de::DeserializeOwned;

pub async fn get<T>(headers: HeaderMap, url: &str) -> Result<T, ExitFailure>
where
    T: DeserializeOwned,
{
    Ok(Client::new()
        .get(url)
        .headers(headers)
        .send()
        .await?
        .json::<T>()
        .await?)
}
