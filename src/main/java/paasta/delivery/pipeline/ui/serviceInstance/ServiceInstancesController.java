package paasta.delivery.pipeline.ui.serviceInstance;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by hrjin on 2017-05-29.
 */
@Controller
@RequestMapping(value = "/dashboard/{suid}")
public class ServiceInstancesController {

    private static final String BASE_URL = "/serviceInstance";
    private final ServiceInstancesService serviceInstancesService;

    @Autowired
    public ServiceInstancesController(ServiceInstancesService serviceInstancesService) {
        this.serviceInstancesService = serviceInstancesService;
    }


    /*
    *  목록 조회
    *
    * */
    @RequestMapping(value = {BASE_URL + "/dashboard"}, method = RequestMethod.GET)
    public ModelAndView getServiceInstances(){
        ModelAndView mv = new ModelAndView();
        mv.addObject("list", serviceInstancesService.getServiceInstancesList());
        mv.setViewName(BASE_URL + "/serviceInstanceList");
        return mv;
    }



    /*
    * 나중에 broker 에서 서비스 인스턴스 생성하도록 연결
    *
    * */
    @RequestMapping(value = {BASE_URL + "/create"}, method = RequestMethod.GET)
    public ModelAndView getServiceInstancesCreatePage(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName(BASE_URL + "/serviceInstanceCreate");
        return mv;
    }


    /*
    *  상세 조회
    *
    * */
    @RequestMapping(value = {BASE_URL + "/detail/{id}"}, method = RequestMethod.GET)
    public ModelAndView getServiceInstancesDetailPage(@PathVariable("id") String id){
        ModelAndView mv = new ModelAndView();
        mv.addObject("id", id);
        mv.setViewName(BASE_URL + "/serviceInstanceDetail");
        return mv;
    }


    /*
    *  삭제
    *
    * */
    @RequestMapping(value = {BASE_URL + "/serviceInstanceDelete.do"}, method = RequestMethod.POST)
    @ResponseBody
    public ServiceInstances setDeleteServiceInstance(@RequestBody ServiceInstances serviceInstances){
        return serviceInstancesService.setDeleteServiceInstance(serviceInstances.getId());
    }



    @RequestMapping(value = {BASE_URL + "/serviceInstanceList.do"}, method = RequestMethod.POST)
    @ResponseBody
    public List<ServiceInstances> getServiceInstanceList(){
        return serviceInstancesService.getServiceInstancesList();
    }


    @RequestMapping(value = {BASE_URL + "/serviceInstanceCreate.do"}, method = RequestMethod.POST)
    @ResponseBody
    public ServiceInstances setCreateServiceInstances(@RequestBody ServiceInstances serviceInstances){
        return serviceInstancesService.setCreateServiceInstances(serviceInstances);
    }


    @RequestMapping(value = {BASE_URL + "/serviceInstanceDetail.do"}, method = RequestMethod.POST)
    @ResponseBody
    public ServiceInstances getServiceInstances(@RequestBody ServiceInstances serviceInstances){
        return serviceInstancesService.getServiceInstances(serviceInstances.getId());
    }

}
