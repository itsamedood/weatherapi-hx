/*
 * MIT License
 *
 * Copyright (c) 2022 itsamedood
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package weather.api;

import haxe.Exception;
import sys.Http;
import weather.api.types.*;

using StringTools;

/**
 * Class for interacting with **https://www.weatherapi.com/**.
 */
class WeatherAPI
{
	private var key(default, null):String;

	private static inline final BASE_URL:String = "http://api.weatherapi.com/v1";

	/**
	 * Creates a new instance that can be used to get weather information.
	 *
	 * @param key Your API key (**https://www.weatherapi.com/my/**).
	 */
	public function new(key:String)
	{
		this.key = key;
	}

	/**
	 * Gets the current weather.
	 *
	 * @param params Structure of parameters for the request. `aqi` = `false` by default, and `format` = `JSON` by default.
	 *
	 * @return Either `JSON` or `XML` formatted data as a `String` depending on specified parameters. `null` is returned if your API key is invalid, or the query lead to nothing.
	 */
	public function getCurrent(params:CurrentParams):Null<String>
	{
		if (params.aqi == null)
			params.aqi = false;
		if (params.format == null)
			params.format = JSON;

		try
		{
			return
				Http.requestUrl('$BASE_URL/current.${params.format}?key=$key&q=${params.query}&aqi=${params.aqi == null || params.aqi == false ? "no" : "yes";}');
		}
		catch (e:Exception)
		{
			e.message.endsWith("401") ? {
				Sys.println("WAPI-Error: Invalid API key.");
				return null;
			} : e.message.endsWith("400") ? {
				Sys.println("WAPI-Error: Location not found.");
				return null;
				} : {Sys.println(e.message); return null;}
			{
				Sys.println(e.message);
				return null;
			};
		}
	}

	/**
	 * Gets the forecast.
	 *
	 * @param params Structure of parameters for the request. `days` = `1` by default, `aqi` & `alerts` both = `false` by default, and `format` = `JSON` by default.
	 *
	 * @return Either `JSON` or `XML` formatted data as a `String` depending on specified parameters. `null` is returned if your API key is invalid, or the query lead to nothing.
	 */
	public function getForecast(params:ForecastParams):Null<String>
	{
		if (params.days == null)
			params.days = 1;
		if (params.aqi == null)
			params.aqi = false;
		if (params.alerts == null)
			params.alerts = false;
		if (params.format == null)
			params.format = JSON;

		try
		{
			return
				Http.requestUrl('$BASE_URL/forecast.${params.format}?key=$key&q=${params.query}&days=${params.days}&aqi=${params.aqi == null || params.aqi == false ? "no" : "yes";}&alerts=${params.alerts == null || params.alerts == false ? "no" : "yes";}');
		}
		catch (e:Exception)
		{
			e.message.endsWith("401") ? {
				Sys.println("WAPI-Error: Invalid API key.");
				return null;
			} : e.message.endsWith("400") ? {
				Sys.println("WAPI-Error: Location not found.");
				return null;
				} : {Sys.println(e.message); return null;}
			{
				Sys.println(e.message);
				return null;
			};
		}
	}

	/* Left this undocumented because I have no idea what this does in the API.
		Read the docs here and see if you
		can figure out what it does, then create
		a GitHub discussion about it and I'll update it.

		API Documentation: https://www.weatherapi.com/docs/ */
	public function getSearchOrAutoComplete(params:SearchOrAutoCompleteParams):Null<String>
	{
		if (params.format == null)
			params.format = JSON;

		try
		{
			Http.requestUrl('$BASE_URL/search.${params.format}?key=$key&q=${params.query}')
				.length == 0 ? return null : return Http.requestUrl('$BASE_URL/search.${params.format}?key=$key&q=${params.query}');
		}
		catch (e:Exception)
		{
			e.message.endsWith("401") ? {
				Sys.println("WAPI-Error: Invalid API key.");
				return null;
			} : {Sys.println(e.message); return null;};
		}
	}

	/**
	 * Gets the history of a location from a date.
	 *
	 * ### **Sadly, this can only be used if you have an upgraded plan for the API.**
	 *
	 * For more information: **https://www.weatherapi.com/pricing.aspx**
	 *
	 * @param params Structure of parameters for the request. `date` = `2010-1-1` by default, and `format` = `JSON` by default.
	 *
	 * @return Either `JSON` or `XML` formatted data as a `String` depending on specified parameters. `null` is returned if your API key is invalid, or the query lead to nothing.
	 */
	public function getHistory(params:HistoryParams):Null<String>
	{
		if (params.date == null)
			params.date = "2010-1-1";
		if (params.format == null)
			params.format = JSON;

		try
		{
			return Http.requestUrl('$BASE_URL/history.${params.format}?key=$key&q=${params.query}&dt=${params.date}');
		}
		catch (e:Exception)
		{
			e.message.endsWith("401") ? {
				Sys.println("WAPI-Error: Invalid API key.");
				return null;
			} : e.message.endsWith("400") ? {
				Sys.println("WAPI-Error: API key is limited (or no location was found).");
				return null;
				} : {Sys.println(e.message); return null;}
			{
				Sys.println(e.message);
				return null;
			};
		}
	}

	/**
	 * Gets astronomy information on a location from a date.
	 *
	 * @param params Structure of parameters for the request. `date` = `2010-1-1` by default, and `format` = `JSON` by default.
	 *
	 * @return Either `JSON` or `XML` formatted data as a `String` depending on specified parameters. `null` is returned if your API key is invalid, or the query lead to nothing.
	 */
	public function getAstronomy(params:AstronomyParams):Null<String>
	{
		if (params.date == null)
			params.date = "2010-1-1";
		if (params.format == null)
			params.format = JSON;

		try
		{
			return Http.requestUrl('$BASE_URL/astronomy.${params.format}?key=$key&q=${params.query}&dt=${params.date}');
		}
		catch (e:Exception)
		{
			e.message.endsWith("401") ? {
				Sys.println("WAPI-Error: Invalid API key.");
				return null;
			} : e.message.endsWith("400") ? {
				Sys.println("WAPI-Error: Location not found.");
				return null;
				} : {Sys.println(e.message); return null;}
			{
				Sys.println(e.message);
				return null;
			};
		}
	}

	/**
	 * Gets the time zone the specified location is in.
	 *
	 * @param params Structure of paramters for the request. `format` = `JSON` by default.
	 *
	 * @return Either `JSON` or `XML` formatted data as a `String` depending on specified parameters. `null` is returned if your API key is invalid, or the query lead to nothing.
	 */
	public function getTimeZone(params:TimeZoneParams):Null<String>
	{
		if (params.format == null)
			params.format = JSON;

		try
		{
			return Http.requestUrl('$BASE_URL/timezone.${params.format}?key=$key&q=${params.query}');
		}
		catch (e:Exception)
		{
			e.message.endsWith("401") ? {
				Sys.println("WAPI-Error: Invalid API key.");
				return null;
			} : e.message.endsWith("400") ? {
				Sys.println("WAPI-Error: Location not found.");
				return null;
				} : {Sys.println(e.message); return null;}
			{
				Sys.println(e.message);
				return null;
			};
		}
	}

	/**
	 * Gets the sports from a specific location.
	 *
	 * @param params Structure of parameters for the request. `format` = `JSON` by default.
	 *
	 * @return Either `JSON` or `XML` formatted data as a `String` depending on specified parameters. `null` is returned if your API key is invalid, or the query lead to nothing.
	 */
	public function getSports(params:SportsParams):Null<String>
	{
		if (params.format == null)
			params.format = JSON;

		try
		{
			return Http.requestUrl('$BASE_URL/sports.${params.format}?key=$key&q=${params.query}');
		}
		catch (e:Exception)
		{
			e.message.endsWith("401") ? {
				Sys.println("WAPI-Error: Invalid API key.");
				return null;
			} : e.message.endsWith("400") ? {
				Sys.println("WAPI-Error: Location not found.");
				return null;
				} : {Sys.println(e.message); return null;}
			{
				Sys.println(e.message);
				return null;
			};
		}
	}
}
