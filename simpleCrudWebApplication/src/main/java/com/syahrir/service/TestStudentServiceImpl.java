package com.syahrir.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.syahrir.entity.TestStudent;
import com.syahrir.form.TestStudentForm;
import com.syahrir.repository.TestStudentRepo;

@Service
@Component
public class TestStudentServiceImpl implements TestStudentService{
	
	private final TestStudentRepo testStudentRepo;
	
	@Autowired
	public TestStudentServiceImpl(final TestStudentRepo testStudentRepo){
		this.testStudentRepo = testStudentRepo;
	}

	public void save(TestStudentForm form) {
		TestStudent student = new TestStudent();
		student.setId(form.getId());
		student.setName(form.getName());
		student.setAddress(form.getAddress());
		student.setDob(form.getDob());
		student.setGender(form.getGender());
		student.setMobile(form.getMobile());
		student.setPhone(form.getPhone());
		student.setEmail(form.getEmail());
		
		testStudentRepo.save(student);
		
	}

	public List<TestStudent> findAll() {
		return (List<TestStudent>) testStudentRepo.findAll();
	}

	public void byId(int id) {
		testStudentRepo.delete(id);
	}

	public void findById(int id,TestStudentForm form) {
		TestStudent student = testStudentRepo.findOne(id);
		form.setId(student.getId());
		form.setName(student.getName());
		form.setEmail(student.getEmail());
		form.setDob(student.getDob());
		form.setAddress(student.getAddress());
		form.setGender(student.getGender());
		form.setMobile(student.getMobile());
		form.setPhone(student.getPhone());
		
	}
	
}
