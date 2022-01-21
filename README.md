# **WeatherAPI-hx**
## An API wrapper for **https://www.weatherapi.com/**
---
> # **About**
> ## *weatherapi-hx is a Haxe library for interacting with https://www.weatherapi.com/. You can get all sorts of weather-related data in either JSON or XML format!*
> ---
> # **Installation**
> ```txt
> haxelib install weatherapi-hx
> ```
> ---
> # **Example**
> ```hx
> import weather.api.WeatherAPI;
>
> class Main
> {
>	static inline function main():Void
>	{
>		var wapi = new WeatherAPI("your-api-key-here");
>
>		// returns timezone data for London in JSON format.
>		wapi.getTimeZone({query: "London"});
>	}
> }
> ```
> ---
> # **Documentation**
> ## * **All function parameters have these 2, so I'll document them here:**
> - query:String | "city/state/country name, IP address, etc." `(THIS PARAMETER IS ALWAYS REQUIRED!)`
> - format:Null\<Format\> | `JSON` or `XML` (`JSON` by default.)
> ## **Now onto the others:**
> - `getAstronomy()`
>> ### **Params:** date:Null\<String\> (`"2010-1-1"` by default.) | Date to fetch astronomy data from. Format must be `yyyy-MM-dd`. Date must be on or after `2010-1-1`.
> ---
> - `getCurrent()`
>> ### **Params:** aqi:Null\<Bool\> (`false` by default.) | Get air quality data.
> ---
> - `getForecast()`
>> ### **Params:** days:Null\<Int\> (`1` by default.) | Number of days of weather forecast. Value ranges from `1` to `10`. | alerts:Null\<Bool\> (`false` by default.) | Get weather alert data. | aqi:Null\<Bool\> (`false` by default.) | Get air quality data.
> ---
> ## \* **NOTE:** You need to have an upgraded API plan to use this function. Yes, I agree that it's stupid. You can read more about this [here](https://www.weatherapi.com/pricing.aspx).
> - `getHistory()`
>> ### **Params:** date:Null\<String\> (`"2010-1-1"` by default.) | Date to fetch history info from. Format must be `yyyy-MM-dd`. Date must be on or after `2010-1-1`.
> ---
> - `getSearchOrAutoComplete()`
>> ### **Params:** Just the 2 standard ones.
> ---
> - `getSports()`
>> ### **Params:** Just the 2 standard ones.
> ---
> - `getTimeZone()`
>> ### **Params:** Just the 2 standard ones.
> ---
#### **- itsamedood :)**
