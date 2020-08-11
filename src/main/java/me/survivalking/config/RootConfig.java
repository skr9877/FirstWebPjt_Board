//package me.survivalking.config;
//
//import javax.sql.DataSource;
//
//import org.apache.ibatis.session.SqlSessionFactory;
//import org.mybatis.spring.SqlSessionFactoryBean;
//import org.mybatis.spring.annotation.MapperScan;
//import org.springframework.beans.factory.annotation.Configurable;
//import org.springframework.context.annotation.Bean;
//
//import com.zaxxer.hikari.HikariConfig;
//import com.zaxxer.hikari.HikariDataSource;
//
//// root-context.xml
//@Configurable
//@MapperScan(basePackages = {"me.survivalking.mapper"})
//public class RootConfig {
//	
//	@Bean
//	public DataSource dataSource() {
//		HikariConfig hikariConfig = new HikariConfig();
//		hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
//		hikariConfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:127.0.0.1:1521:orcl");
//		
//		hikariConfig.setUsername("WEB_USER");
//		hikariConfig.setPassword("gmltjr1177");
//		
//		HikariDataSource dataSource = new HikariDataSource(hikariConfig);
//		
//		return dataSource;
//	}
//	
//	@Bean
//	public SqlSessionFactory sqlSessionFactory() throws Exception{
//		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
//		sqlSessionFactory.setDataSource(dataSource());
//		
//		return (SqlSessionFactory)sqlSessionFactory.getObject();
//	}
//}
