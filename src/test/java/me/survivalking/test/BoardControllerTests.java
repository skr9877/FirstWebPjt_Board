package me.survivalking.test;

import static org.junit.Assert.assertNotNull;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import me.survivalking.mapper.BoardMapperTest;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration // Test for Controller
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	                   "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class BoardControllerTests {
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc  = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testList() throws Exception{
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
				.andReturn()
				.getModelAndView().getModelMap()
		);
		
	}
	
	//@Test
	public void testReigister() throws Exception{
		String resultPage =
				mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
						.param("title", "20200809")
						.param("content", "20200809而⑦뀗痢�2")
						.param("writer", "user03")
				)
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
		
	}
	
	//@Test
	public void testGetList() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
				.param("bno","2")
				).
				andReturn().getModelAndView().getModelMap());

	}
	
	//@Test
	public void testModify() throws Exception{
		String resultPage =
				mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
						.param("bno", "2")
						.param("title", "�닔�젙�맂 �젣紐�")
						.param("content", "�닔�젙�맂 而⑦뀗痢�")
				)
				.andReturn().getModelAndView().getViewName();
		
		log.info(resultPage);
		
	}
	
	
}
