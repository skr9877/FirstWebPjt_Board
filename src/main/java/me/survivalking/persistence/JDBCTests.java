package me.survivalking.persistence;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	// C:\app\heesukkim\product\11.2.0\dbhome_1\jdbc\lib ojdbc설치 경로
	@Test
	public void testConnection() {
		try(Connection conn = DriverManager.getConnection("jdbc:oracle:thin:127.0.0.1:1521:orcl", "WEB_USER", "gmltjr1177")){
			log.info(conn);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}
