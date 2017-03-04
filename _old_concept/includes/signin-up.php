        <div class="mid-container">
            <div class="errors"></div>
            
            <div class="login_container">
                <form method="POST" id="login_form" action="login.php">
                    <div class="div_sign form_title">
                        <b>Login</b>
                    </div>
                    <div class="div_sign">
                        <label for="email">E-mail</label>
                        <input type="email" id="email" class="mlogin mandatory sign"/> 
                    </div>

                    <div class="div_sign">
                        <label for="pw">Password</label>
                        <input type="password" id="pw" class="mlogin mandatory sign"/> 
                    </div>

                    
                    <button type="button" id="login_button" class="login">Login</button>
                    
                </form>
            </div>

            <div class="register_container">
                <form method="POST" id="regiter_form" action="register.php">
                    <div class="div_sign form_title">
                        <b>Register</b>
                    </div>
                    <div class="div_sign">
                        <label for="email2">E-mail</label>
                        <input type="email" class="mregister mandatory sign" id="email2"/> 
                    </div>

                    <div class="div_sign">
                        <label for="name">Name</label>
                        <input type="text"  class="mregister mandatory sign" id="name"/> 
                    </div>

                    <div class="div_sign">
                        <label for="surname">Surname</label>
                        <input type="email"  class="mregister mandatory sign" id="surname"/> 
                    </div>

                    <div class="div_sign">
                        <label for="pw2">Password</label>
                        <input type="password" id="pw2" class="pw mregister mandatory sign"/> 
                    </div>

                    <div class="div_sign">
                        <label for="cpw">Verify Password</label>
                        <input type="password" id="cpw" class="cpw mregister mandatory sign"/> 
                    </div>

                    
                    <button type="button" id="register_button" class="register">Register</button>
                    

                </form>
            </div>
        </div>