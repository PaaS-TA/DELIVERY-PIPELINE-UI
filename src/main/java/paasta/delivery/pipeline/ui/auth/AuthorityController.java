package paasta.delivery.pipeline.ui.auth;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by hrjin on 2017-10-11.
 */
@Controller
@RequestMapping(value = "/dashboard/{suid}")
public class AuthorityController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AuthorityController.class);
    private final AuthorityService authorityService;

    @Autowired
    public AuthorityController(AuthorityService authorityService) {
        this.authorityService = authorityService;
    }

    @RequestMapping(value = "/authorities", method = RequestMethod.GET)
    @ResponseBody
    public List<Authority> getAuthorityList(){
        return authorityService.getAuthorityList();
    }
}
