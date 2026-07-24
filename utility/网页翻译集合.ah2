#Requires AutoHotkey v2.0

logger.is_log_open := true
logger.is_out_console := true

class Deepl_web_cd extends Web_cd
{
    __New()
    {
        url := 'https://www.deepl.com/zh/translator' 
        input_js :='
        (
            {          
                const editor = document.querySelector("d-textarea[name=\"source\"]");
                const inputbox = document.querySelector("d-textarea[name=\"source\"] > div");
                inputbox.textContent = "{1}";
                setTimeout(() => {
                    editor.dispatchEvent(new InputEvent("input"));
                }, 20);
            }
        )'
        out_put_js := '
        (
            {
                
                o = document.querySelector('d-textarea[name=\"target\"]')
                function callback3(records) {
                records.forEach(function(record) {
                    try
                    {
                        //aa = o.querySelector('[class="ordinary-output target-output clearfix"]');
                        console.log(o.textContent);
                        obj = window.chrome.webview.hostObjects.ahk;
                        obj.func(o.textContent);
                    }
                    catch
                    {
                        try
                        {
                            console.log('');
                            obj = window.chrome.webview.hostObjects.ahk;
                            obj.func('');
                        }
                        catch
                        {

                        }
                    }
                })
                }
                var ob3 = new MutationObserver(callback3)
                ob3.observe(o, {
                characterDataOldValue: true,
                attributes: true,
                childList: true,
                characterData: true,
                subtree: true
                })
            }
        )'
        super.__New(url, input_js, out_put_js,, 'deepl')
    }
    __Delete()
    {
        
    }
}

class Baidu_web_cd extends Web_cd
{
    __New()
    {
        url := 'https://fanyi.baidu.com/' 
        input_js :='
        (
            {          
                let inputbox = document.querySelector("#baidu_translate_input");
                inputbox.value = "{1}";
                let e = document.createEvent("HTMLEvents");
                e.initEvent("input");
                inputbox.dispatchEvent(e);
            }
        )'
        out_put_js := '
        (
            {
                
                o = document.querySelector(".output-wrap")
                function callback3(records) {
                records.forEach(function(record) {
                    try
                    {
                        aa = o.querySelector('[class="ordinary-output target-output clearfix"]');
                        console.log(aa.textContent);
                        obj = window.chrome.webview.hostObjects.ahk;
                        obj.func(aa.textContent);
                    }
                    catch
                    {
                        try
                        {
                            console.log('');
                            obj = window.chrome.webview.hostObjects.ahk;
                            obj.func('');
                        }
                        catch
                        {

                        }
                    }
                })
                }
                var ob3 = new MutationObserver(callback3)
                ob3.observe(o, {
                characterDataOldValue: true,
                attributes: true,
                childList: true,
                characterData: true,
                subtree: true
                })
            }
        )'
        super.__New(url, input_js, out_put_js,, 'baidu')
    }
    __Delete()
    {
        
    }
}

class Youdao_web_cd extends Web_cd
{
    __New()
    {
        url := 'https://fanyi.youdao.com/indexLLM.html#/' 
        input_js :='
        (
            {     
                let inputbox = document.getElementById("js_fanyi_input");
                inputbox.textContent = "{1}";
                let e = document.createEvent("HTMLEvents");
                e.initEvent("input");
                inputbox.dispatchEvent(e);
            }
        )'
        out_put_js := '
        (
            o = document.querySelector("#js_fanyi_output")
            function callback3(records) {
            records.forEach(function(record) {
                try
                {
                    console.log(document.querySelector("#js_fanyi_output_resultOutput").textContent);
                    obj = window.chrome.webview.hostObjects.ahk;
                    obj.func(document.querySelector("#js_fanyi_output_resultOutput").textContent);
                }
                catch
                {
                    try
                    {
                        obj = window.chrome.webview.hostObjects.ahk;
                        obj.func('');
                    }
                    catch
                    {

                    }
                }
            })
            }
            var ob3 = new MutationObserver(callback3)
            ob3.observe(o, {
            characterDataOldValue: true,
            attributes: true,
            childList: true,
            characterData: true,
            subtree: true
            })
        )'
        super.__New(url, input_js, out_put_js,, 'youdao')
    }
    __Delete()
    {
        
    }
}


class Sougou_web_cd extends Web_cd
{
    __New()
    {
        url := 'https://fanyi.sogou.com/text?keyword=friend&transfrom=auto&transto=zh-CHS&model=general' 
        input_js :='
        (
            {
                let inputbox = document.getElementById("trans-input");
                inputbox.value = "{1}";
                let e = document.createEvent("HTMLEvents");
                e.initEvent("input");
                inputbox.dispatchEvent(e);
                document.querySelector("#trans-result").textContent
            }
        )'
        out_put_js := '
        (
            o=document.querySelector("#trans-to > div > div.output")
            function callback3(records) {
            records.forEach(function(record) {
                try
                {
                    console.log(o.firstElementChild.textContent);
                    obj = window.chrome.webview.hostObjects.ahk;
                    obj.func(o.firstElementChild.textContent);
                }
                catch
                {
                    try
                    {
                        obj = window.chrome.webview.hostObjects.ahk;
                        obj.func(o.textContent);
                    }
                    catch
                    {

                    }
                }
            })
            }
            var ob3 = new MutationObserver(callback3)
            ob3.observe(o, {
            characterDataOldValue: true,
            attributes: true,
            childList: true,
            characterData: true,
            subtree: true
            })
        )'
        super.__New(url, input_js, out_put_js,, 'sougou')
    }
    __Delete()
    {
        
    }
}

class Google_web_cd extends Web_cd
{
    __New()
    {
        url := 'https://translate.google.com/?sl=auto&tl=en'
        input_js :='
        (
            {
                const area = document.querySelector("textarea[aria-label='\''Source text'\'']");
                if (area) {
                    area.value = "{1}";
                    area.dispatchEvent(new Event("input", {bubbles: true}));
                }
            }
        )'
        out_put_js := '
        (
            {
                let last = "";
                const callback = () => {
                    try {
                        const resultEl = document.querySelector("[data-language-for-alternatives]");
                        const text = resultEl ? resultEl.innerText : "";
                        if (text && text !== last) {
                            last = text;
                            obj = window.chrome.webview.hostObjects.ahk;
                            obj.func(text);
                        }
                    } catch(e) {
                        console.log(e);
                    }
                };
                const target = document.querySelector("c-wiz");
                if (target) {
                    new MutationObserver(callback).observe(target, {
                        childList: true, subtree: true, characterData: true
                    });
                }
            }
        )'
        super.__New(url, input_js, out_put_js,, 'google')
    }
}

class Bing_web_cd extends Web_cd
{
    __New()
    {
        url := 'https://www.bing.com/translator'
        input_js :='
        (
            {
                const inputbox = document.querySelector("#tta_input_ta");
                if (inputbox) {
                    inputbox.value = "{1}";
                    inputbox.dispatchEvent(new Event("input", {bubbles: true}));
                }
            }
        )'
        out_put_js := '
        (
            {
                let last = "";
                const callback = () => {
                    try {
                        o = document.querySelector("#tta_output_ta");
                        const text = o ? (o.value || o.textContent) : "";
                        if (text && text !== last) {
                            last = text;
                            obj = window.chrome.webview.hostObjects.ahk;
                            obj.func(text);
                        }
                    } catch(e) {
                        console.log(e);
                    }
                };
                const target = document.querySelector("#tta_output_ta");
                if (target) {
                    new MutationObserver(callback).observe(target, {
                        attributes: true, childList: true, characterData: true, subtree: true
                    });
                }
            }
        )'
        super.__New(url, input_js, out_put_js,, 'bing')
    }
}

class Tencent_web_cd extends Web_cd
{
    __New()
    {
        url := 'https://fanyi.qq.com/'
        input_js :='
        (
            {
                const inputbox = document.querySelector("textarea[placeholder='\''请输入要翻译的文字'\'']");
                if (inputbox) {
                    inputbox.value = "{1}";
                    inputbox.dispatchEvent(new Event("input", {bubbles: true}));
                }
            }
        )'
        out_put_js := '
        (
            {
                let last = "";
                const callback = () => {
                    try {
                        const resultEls = document.querySelectorAll(".text-output");
                        const text = resultEls.length > 1
                            ? resultEls[1].textContent.replace(/\s+/g, " ").trim()
                            : (resultEls[0] ? resultEls[0].textContent.replace(/\s+/g, " ").trim() : "");
                        if (text && text !== last) {
                            last = text;
                            obj = window.chrome.webview.hostObjects.ahk;
                            obj.func(text);
                        }
                    } catch(e) {
                        console.log(e);
                    }
                };
                const target = document.querySelector(".text-output");
                if (target) {
                    new MutationObserver(callback).observe(target, {
                        attributes: true, childList: true, characterData: true, subtree: true
                    });
                }
            }
        )'
        super.__New(url, input_js, out_put_js,, 'tencent')
    }
}

class Web_cd
{
    __New(url, input_js, output_js, out_change_call_back := unset, ui_name := '翻译')
    {
        this.url := url
        this.input_js := input_js
        this.output_js := output_js
        this.ui_name := ui_name
        if(IsSet(out_change_call_back))
            this.out_change_call_back := out_change_call_back

        this.ui := Gui('+AlwaysOnTop -DPIScale +Caption +Border +LastFound -ToolWindow +Resize -HScroll', ui_name)
        this.ui.Show(Format("x-5000 y-5000 w{} h{}", A_ScreenWidth * 0.5, A_ScreenHeight * 0.5))
        this.wv := WebView2.create(this.ui.Hwnd)
        this.nav_sync := SyncHandler()
        this.exec_sync := SyncHandler((args) => OutputDebug(StrGet(args[2])))
        this.wv.CoreWebView2.add_NavigationCompleted(this.nav_sync)
        this.wv.CoreWebView2.Navigate(this.url )
        btt(ui_name ' 加载中。。。',0, 0,,OwnzztooltipStyle1,{Transparent:180,DistanceBetweenMouseXAndToolTip:-100,DistanceBetweenMouseYAndToolTip:-20})
        if(!this.nav_sync.wait(10000))
        {
            btt(ui_name ' 加载失败',0, 0,,OwnzztooltipStyle1,{Transparent:180,DistanceBetweenMouseXAndToolTip:-100,DistanceBetweenMouseYAndToolTip:-20})
            sleep(200)
        }
        this.wv.CoreWebView2.AddHostObjectToScript('ahk', {str:'str from ahk',func:this.on_result_change.Bind(this)})
        Sleep(1000)
        this.set_change_event()
        this.ui.OnEvent('Size', this.gui_size.Bind(this))
        this.ui.Hide()
    }
    __Delete()
    {
        this.ui := ''
    }

    set_out_change_call_back(fc)
    {
        this.out_change_call_back := fc
    }

    set_input_box(text)
    {
        js := Format(this.input_js, text)
        return rtn := this.wv.CoreWebView2.ExecuteScript(js, 0)
    }

    on_result_change(out_text)
    {
        logger.info(out_text)
        p := this.out_change_call_back
        if(IsSet(p))
            (this.out_change_call_back)(this.ui_name, out_text)
    }
    show(x := 0, y := 0, w := 200, h := 200)
    {
        this.ui.Show(Format("x{} y{} w{} h{}", x, y, w, h))
    }
    gui_size(GuiObj, MinMax, Width, Height) 
    {
        if (MinMax != -1) 
            this.wv.Fill()
    }
    set_change_event()
    {
        rtn := this.wv.CoreWebView2.ExecuteScript(this.output_js, 0)
    }
}