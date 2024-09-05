// メニュー操作

// トグルリスナーを追加して、クリックをリッスン

document.addEventListener("turbo:load", function(){
    let account = document.querySelector("#account");
    if (account) {
        account.addEventListener("click",function(e){
            e.preventDefault();
            let menu=document.querySelector("#dropdown-menu");
            menu.classList.toggle("active");
        })
    }
})