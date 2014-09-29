package com.syahrir.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.syahrir.entity.TestStudent;
import com.syahrir.form.TestStudentForm;
import com.syahrir.service.TestStudentService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	private final TestStudentService testStudentsService;
	
	
	@Autowired
	public MainController(final TestStudentService testStudentsService){
		this.testStudentsService = testStudentsService;
	}
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		TestStudentForm form = new TestStudentForm();
		model.addAttribute("testStudentForm",form);
		return "home";
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public String edit(Model model,@PathVariable("id") final int id) {
		TestStudentForm form = new TestStudentForm();
		model.addAttribute("testStudentForm",form);
		if(id != 0)
			testStudentsService.findById(id,form);
		return "home";
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(@ModelAttribute("testStudentForm") TestStudentForm form) {
		
		logger.info(form.getName());
		
		testStudentsService.save(form);
		
		return "home";
		
	}
	
	
	@RequestMapping(value = "/findAll", method = RequestMethod.GET)
	public @ResponseBody List<String[]> findAll() {
		
		List<String[]> list = new ArrayList<String[]>();
		
		List<TestStudent> studentList = testStudentsService.findAll();
		for (TestStudent testStudent : studentList) {
			
			String [] form = {String.valueOf(testStudent.getId()),testStudent.getName(),testStudent.getAddress(),testStudent.getEmail(),testStudent.getDob().toString(),testStudent.getMobile(),testStudent.getPhone(),testStudent.getGender()};
			list.add(form);
		}
		
		return list;
	}
	
	
	@RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
	public @ResponseBody String delete(@PathVariable("id") final int id) {
		
		testStudentsService.byId(id);
		return "success";
	}
	
}
