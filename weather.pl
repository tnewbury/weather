#!/usr/bin/perl



while (monkey==0) {
	system("wget -N -q http://www.isleofwightweather.com/clientraw.txt");
	system("wget -N -q http://www.isleofwightweather.com/clientrawextra.txt");
	
	$weather = './clientraw.txt';
	$weatherextra = './clientrawextra.txt';
	$websource = './webpage/index.tmp';
	$webdest = '/var/www/html/index.html';
	open (WEBDEST, ">$webdest");
	open (WEBSOURCE, "<$websource");
	open (WEATHER, "<$weather") ;
	open (WEATHEREXTRA, "<$weatherextra");
	
	while(<WEBSOURCE>){
		$webcontent .= $_ ;
		#print $webcontent;
	}
	
	@aweather = split(" ", <WEATHER>);
	@aweatherextra = split(" ", <WEATHEREXTRA>);
	$datestring = localtime();
	system("clear");
	
	
	
	print "$datestring\n";
	$maininfo = "Current : @aweather[49] -- Forecast : @aweatherextra[531]\n";
	print $maininfo;
	$webcontent =~ s/ddmaininfodd/$maininfo/g;
	print "Temp : @aweather[4]C -- Humidity : @aweather[5]%\n";
	$webcontent =~ s/ddTempdd/@aweather[4]/g;
	$webcontent =~ s/ddhumiddd/@aweather[5]/g;
	print "Windchill : @aweather[44]C\n";
	
	$mphwind = int((@aweather[1] * 1.15078) + 0.5);
	print "AVG Wind speed  : $mphwind mph\n";
	$webcontent =~ s/ddWinddd/$mphwind/g;
	
	$mphgust = int((@aweather[2] * 1.15078) + 0.5);
	print "Gusts : $mphwind mph\n";
	$webcontent =~ s/ddGustdd/$mphgust/g;
	
	print "Wind Direction : @aweather[3] deg\n";
	print "Cloud Height : @aweather[73]ft\n";
	print "Barometer : @aweather[6]hPa\n";
	print "Sunrise : @aweatherextra[556]\n";
	print "Sunset : @aweatherextra[557]\n";
	print "SolarWM : @aweather[127]wm/2\n";
	print "Moonrise : @aweatherextra[558]\n";
	print "Moonset : @aweatherextra[559]\n";
	print "Moon Phase : @aweatherextra[560]%\n";
	
	print "Rain Rate : @aweather[11]mm\n";
	$webcontent =~ s/ddrainratedd/@aweather[11]/g;
	print "Daily Rainfall : @aweather[7]mm\n";
	$webcontent =~ s/ddRFalldaydd/@aweather[7]/g;
	print "Monthly Rainfall : @aweather[8]mm\n";
	$webcontent =~ s/ddRFallmonthdd/@aweather[8]/g;
	print "Annual Rainfall : @aweather[9]mm\n";
	$webcontent =~ s/ddRFallYeardd/@aweather[9]/g;
	
	print "Lightning in last minute : @aweather[114]\n";
	print "Time/date of last strike : @aweather[115] @aweather[116]\n";
	print "Location of last strike : @aweather[118]Miles, @aweather[119] Degs\n";
	
	print WEBDEST $webcontent;
	close WEBSOURCE;
	close WEBDEST;
	close WEATHER;
	close WEATHEREXTRA;
	$webcontent="";

	sleep(10);
	
}
