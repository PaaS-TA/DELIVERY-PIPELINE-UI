package paasta.delivery.pipeline.ui.serviceInstance;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import paasta.delivery.pipeline.ui.user.UserService;

import java.util.List;


/**
 * Created by hrjin on 2017-06-07.
 */

@Controller
@RequestMapping(value = "/dashboard/{suid}")
public class InstanceUseController {
    private final Logger logger = LoggerFactory.getLogger(getClass());

    private static final String BASE_URL = "/instanceUse";
    private final InstanceUseService instanceUseService;
    private final ServiceInstancesService serviceInstancesService;
    private final UserService userService;

    @Autowired
    public InstanceUseController(InstanceUseService instanceUseService, ServiceInstancesService serviceInstancesService, UserService userService) {
        this.instanceUseService = instanceUseService;
        this.serviceInstancesService = serviceInstancesService;
        this.userService = userService;
    }

    /*@Autowired
    public InstanceUseController(InstanceUseService instanceUseService) {
        this.instanceUseService = instanceUseService;
    }*/


    /*
    * 목록 조회 ::: Page
    *
    * */
    @RequestMapping(value = {BASE_URL + "/dashboard"}, method = RequestMethod.GET)
    public ModelAndView getInstanceUseList(){
        ModelAndView mv = new ModelAndView();
        mv.addObject("list", instanceUseService.getInstanceUseList());
        mv.setViewName(BASE_URL + "/instanceUseList");
        return mv;
    }



    /*
    * 상세 조회 ::: Page
    *
    * */
    @RequestMapping(value = {BASE_URL + "/detail/{id}/{serviceInstanceId}/{userId}"}, method = RequestMethod.GET)
    public ModelAndView getInstanceUse(@PathVariable String serviceInstanceId, @PathVariable String userId, @PathVariable long id){
        ModelAndView mv = new ModelAndView();
        mv.addObject("id", id);
        mv.addObject("serviceInstanceId", serviceInstanceId);
        mv.addObject("userId", userId);
        mv.setViewName(BASE_URL + "/instanceUseDetail");
        return mv;
    }



    /*
    * 생성 ::: Page (실제로는 직접 수동 생성이 되지 않는 기능)
    *
    * */
    @RequestMapping(value = {BASE_URL + "/create"}, method = RequestMethod.GET)
    public ModelAndView getInstanceUseCreatePage(){
        ModelAndView mv = new ModelAndView();
        mv.addObject("userInfo", userService.getUserList(""));
        mv.addObject("serviceInstanceInfo", serviceInstancesService.getServiceInstancesList());
        mv.setViewName(BASE_URL + "/instanceUseCreate");
        return mv;
    }



    /*
    *  삭제 ::: Execute
    *
    * */
    @RequestMapping(value = BASE_URL + "/instanceUseDelete.do", method = RequestMethod.POST)
    @ResponseBody
    public InstanceUse setDeleteInstanceUse(@RequestBody InstanceUse instanceUse){
        return instanceUseService.setDeleteInstanceUse(instanceUse.getServiceInstancesId(), instanceUse.getUserId());
    }



    /*
    *  목록 조회 ::: Execute
    *
    * */
    @RequestMapping(value = {BASE_URL + "/instanceUseList.do"}, method = RequestMethod.GET)
    @ResponseBody
    public List<InstanceUse> instanceUseList(){
        return instanceUseService.getInstanceUseList();
    }



    /*
    *  상세 조회 ::: Execute
    *
    * */
    @RequestMapping(value = {BASE_URL + "/instanceUseDetail.do"}, method = RequestMethod.POST)
    @ResponseBody
    public InstanceUse getInstanceUse(@RequestBody InstanceUse instanceUse){
        return instanceUseService.getInstanceUse(instanceUse.getServiceInstancesId(), instanceUse.getUserId());
    }



    /*
    *  생성 ::: Execute (실제로는 직접 수동 생성이 되지 않는 기능)
    *
    * */
    @RequestMapping(value = {BASE_URL + "/instanceUseCreate.do"}, method = RequestMethod.POST)
    @ResponseBody
    public InstanceUse createInstanceUse(@RequestBody InstanceUse instanceUse){

        if(instanceUse.getServiceInstancesId() != null && instanceUse.getUserId() != null){
            InstanceUse newInstanceUse = instanceUseService.createInstanceUse(instanceUse);
            return newInstanceUse;
        }

        return instanceUseService.getInstanceUse(instanceUse.getServiceInstancesId(), instanceUse.getUserId());
    }
}
