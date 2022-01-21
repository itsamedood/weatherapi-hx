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

package test;

import weather.api.WeatherAPI;

final class Test
{
	public static inline function main():Void
	{
		final wapi:WeatherAPI = new WeatherAPI(test.Key.key); // Key.hx is gitignored so nobody steals my API key lol

		trace(wapi.getAstronomy({query: "London", format: JSON, date: "2015-8-18"}));
		// trace(wapi.getAstronomy({query: "London", format: XML, date: "2015-8-18"}));

		trace(wapi.getCurrent({query: "London", format: JSON, aqi: true}));
		// trace(wapi.getCurrent({query: "London", format: XML, aqi: true}));

		trace(wapi.getForecast({
			query: "London",
			format: JSON,
			days: 7,
			aqi: true,
			alerts: true
		}));
		// trace(wapi.getForecast({
		// 	query: "London",
		// 	format: XML,
		// 	days: 7,
		// 	aqi: true,
		// 	alerts: true
		// }));

		// trace(wapi.getHistory({query: "London", format: JSON, date: "2015-8-18"}));
		// trace(wapi.getHistory({query: "London", format: XML, date: "2015-8-18"}));

		trace(wapi.getSearchOrAutoComplete({query: "London", format: JSON}));
		// trace(wapi.getSearchOrAutoComplete({query: "London", format: XML}));

		trace(wapi.getSports({query: "London", format: JSON}));
		// trace(wapi.getSports({query: "London", format: XML}));

		trace(wapi.getTimeZone({query: "London", format: JSON}));
		// trace(wapi.getTimeZone({query: "London", format: XML}));
	}
}
