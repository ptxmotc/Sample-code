mod util;

use chrono::Utc;
use chrono_tz::GMT;
use exitfailure::ExitFailure;
use reqwest::header::{HeaderMap, AUTHORIZATION};
use serde_json::Value;
use util::{get, signature, Authorization};

const TDX_HOST: &str = "https://ptx.transportdata.tw/MOTC/v2";
const TDX_API_ID: &str = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF";
const TDX_API_KEY: &str = "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF";

fn now() -> String {
    Utc::now().with_timezone(&GMT).to_rfc2822()
}

fn headers(auth: Authorization, time: String) -> HeaderMap {
    let mut headers = HeaderMap::new();

    headers.insert(AUTHORIZATION, auth.to_string().parse().unwrap());
    headers.insert("x-date", time.parse().unwrap());

    headers
}

async fn get_route_in(city: &str) -> Result<Value, ExitFailure> {
    let time = now();

    let auth = Authorization::new(
        TDX_API_ID,
        &signature(
            TDX_API_KEY.as_bytes(),
            format!("x-date: {}", time).as_bytes(),
        ),
    );

    let endpoint = &format!("{}/Bus/Route/City/{}", TDX_HOST, city);

    let res = get::<Value>(headers(auth, time), endpoint).await?;

    Ok(res)
}

#[tokio::main]
async fn main() -> Result<(), ExitFailure> {
    let res = get_route_in("Taipei").await?;

    println!("{:#?}", res);

    Ok(())
}
