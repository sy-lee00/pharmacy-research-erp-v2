package com.sh.haagendazo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

@Configuration
public class SecurityConfig {

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		return http
				.csrf(csrf -> csrf.disable())
				.authorizeHttpRequests(authorize -> authorize
						.requestMatchers("/").authenticated() 
						.anyRequest().permitAll()
				)
				.formLogin(form -> form
						.loginPage("/login")
						.usernameParameter("email")
						.successHandler(customAuthenticationSuccessHandler())
				)
				.logout(logout -> logout
						.logoutUrl("/logout")
						.invalidateHttpSession(true)
						.deleteCookies("JSESSIONID")
						.logoutSuccessUrl("/login")
				)
				.build();
			
	}

	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public HttpFirewall allowUrlEncodedSlashHttpFirewall() {
		StrictHttpFirewall firewall = new StrictHttpFirewall();
		firewall.setAllowUrlEncodedDoubleSlash(true); 
		firewall.setAllowSemicolon(true); 
		return firewall;
		
	}

	@Bean
	public WebSecurityCustomizer webSecurityCustomizer() {
		return web -> web.httpFirewall(allowUrlEncodedSlashHttpFirewall());
	}

	@Bean
	public AuthenticationSuccessHandler customAuthenticationSuccessHandler() {
	    return new CustomAuthenticationSuccessHandler();
	}
}
