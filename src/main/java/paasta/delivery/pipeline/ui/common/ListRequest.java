package paasta.delivery.pipeline.ui.common;

/**
 * Created by hrjin on 2017-05-25.
 */
public class ListRequest {
    private String name;
    private String id;
    private String authName;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String toQueryString(){
        StringBuilder sb = new StringBuilder();

        if(name != null){
            sb.append("name="+name);
        }
        return sb.toString();
    }


    public String getAuthName() {
        return authName;
    }

    public void setAuthName(String authName) {
        this.authName = authName;
    }
}
