import edu.hit.sirtian.ClientApp;
import edu.hit.sirtian.EnrollAdmin;
import edu.hit.sirtian.RegisterUser;
import org.junit.Test;

public class FabricTest {
    @Test
    public void testFabric() throws Exception {
        EnrollAdmin.main(null);
        RegisterUser.main(null);
        System.out.println("now start threads to test!");
        ClientApp.main(null);
    }
}
