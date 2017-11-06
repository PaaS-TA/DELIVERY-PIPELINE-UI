package paasta.delivery.pipeline.ui.cf.url;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping(value = "/dashboard/{serviceInstancesId}/cf-urls")
public class CfUrlController {

    private final CfUrlService cfUrlService;


    @Autowired
    public CfUrlController(CfUrlService cfUrlService) {this.cfUrlService = cfUrlService;}


    @RequestMapping(value = {"/list.do"}, method = RequestMethod.GET)
    @ResponseBody
    public List getCfUrlList(@PathVariable(value = "serviceInstancesId", required = false) String serviceInstancesId) {
        return cfUrlService.getCfUrlList(serviceInstancesId);
    }


    @RequestMapping(value = {"/get.do"}, method = RequestMethod.GET)
    @ResponseBody
    public CfUrl getCfUrl(CfUrl cfUrl) {
        return cfUrlService.getCfUrl(cfUrl);
    }


    @RequestMapping(value = {"/create.do"}, method = RequestMethod.POST)
    @ResponseBody
    public CfUrl setCreateCfUrl(@RequestBody CfUrl cfUrl) {
        return cfUrlService.setCreateCfUrl(cfUrl);
    }


    @RequestMapping(value = {"/update.do"}, method = RequestMethod.POST)
    @ResponseBody
    public CfUrl setUpdateCfUrl(@RequestBody CfUrl cfUrl) {
        return cfUrlService.setUpdateCfUrl(cfUrl);
    }


    @RequestMapping(value = {"/delete.do"}, method = RequestMethod.POST)
    @ResponseBody
    public CfUrl setDeleteCfUrl(@RequestBody CfUrl cfUrl) {
        return cfUrlService.setDeleteCfUrl(cfUrl);
    }

}
