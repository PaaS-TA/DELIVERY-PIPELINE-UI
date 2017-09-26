package paasta.delivery.pipeline.ui.serviceInstance;

import paasta.delivery.pipeline.ui.auth.GrantedAuthority;
import paasta.delivery.pipeline.ui.user.User;

import java.util.List;

/**
 * Created by hrjin on 2017-05-29.
 */
public class InstanceUse {
    private Long id;
    private String resultStatus;
    private String resultMessage;
    private String userId;
    private String serviceInstancesId;
    private ServiceInstances serviceInstances;
    private User user;
    private List<GrantedAuthority> grantedAuthorities;

    private String userDescription;
    private String authListStr;
    private Long pipelineId;

    public InstanceUse() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getResultStatus() {
        return resultStatus;
    }

    public void setResultStatus(String resultStatus) {
        this.resultStatus = resultStatus;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public void setResultMessage(String resultMessage) {
        this.resultMessage = resultMessage;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getServiceInstancesId() {
        return serviceInstancesId;
    }

    public void setServiceInstancesId(String serviceInstancesId) {
        this.serviceInstancesId = serviceInstancesId;
    }

    public List<GrantedAuthority> getGrantedAuthorities() {
        return grantedAuthorities;
    }

    public void setGrantedAuthorities(List<GrantedAuthority> grantedAuthorities) {
        this.grantedAuthorities = grantedAuthorities;
    }

    public ServiceInstances getServiceInstances() {
        return serviceInstances;
    }

    public void setServiceInstances(ServiceInstances serviceInstances) {
        this.serviceInstances = serviceInstances;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }


    public String getAuthListStr() {
        return authListStr;
    }

    public void setAuthListStr(String authListStr) {
        this.authListStr = authListStr;
    }

    public String getUserDescription() {
        return userDescription;
    }

    public void setUserDescription(String userDescription) {
        this.userDescription = userDescription;
    }

    public Long getPipelineId() {
        return pipelineId;
    }

    public void setPipelineId(Long pipelineId) {
        this.pipelineId = pipelineId;
    }
}
