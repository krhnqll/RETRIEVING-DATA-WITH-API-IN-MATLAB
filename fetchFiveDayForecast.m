function [temp, humidity, windSpeed, time] = fetchFiveDayForecast(city)
    % API bağlantı adresi, parametre olarak aldığımız city değişkeni, api key.
    Url = sprintf('http://api.openweathermap.org/data/2.5/forecast?q=%s&appid=%s&units=metric', city, 'cfcb3def6a3fc7f92cb5c9281e73ed90');
    
    try
        % URL'den JSON formatında veri çektiğimiz ve değişkene atadığımız kısım.
        equivalent = webread(Url);
        weatherData = equivalent.list; % Verisi çekilen şehrin verilerinin tutulduğu liste.

            % Verileri dönüştürdüğümüz kısım.
            temp = cellfun(@(x) x.main.temp, weatherData);
            humidity = cellfun(@(x) x.main.humidity, weatherData);
            windSpeed = cellfun(@(x) x.wind.speed, weatherData);
            time = cellfun(@(x) datetime(x.dt, 'ConvertFrom', 'posixtime', 'TimeZone', 'UTC'), weatherData);
            
        
    catch 
        % Kullanıcının şehir ismini yanlış girdiği kısımlarda gireceği yer.
        temp = NaN;
        humidity = NaN;
        windSpeed = NaN;
        time = NaT;
        errorMessage = 'The requested city was not found or data could not be retrieved from the server.';
        disp(errorMessage);
        
    end
end
