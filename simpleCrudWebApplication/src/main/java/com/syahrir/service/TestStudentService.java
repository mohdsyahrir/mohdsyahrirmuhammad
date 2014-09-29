package com.syahrir.service;

import java.util.List;

import com.syahrir.entity.TestStudent;
import com.syahrir.form.TestStudentForm;

public interface TestStudentService {

	void save(TestStudentForm form);

	List<TestStudent> findAll();

	void byId(int id);

	void findById(int id,TestStudentForm form);


}
