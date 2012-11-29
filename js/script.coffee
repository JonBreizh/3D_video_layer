#coffee --watch --compile E:/Partage/Jonathan/_MISC/Documents/3D_video_layer/js/script.coffee

#declaration d'un objet
threeDTV = {
	area : $('body')
	areaPos : $('body').position(),
	movingArea : $('#cube'),
	minHor : 40,
	maxHor : -40,
	minVer : 55,
	maxVer : -30,
	curentX : 0,
	curentY : 0,
	xAngle : 0,
	yAngle : 0,
	transform : 'rotateX('+0+'deg) rotateY('+0+'deg)',
	filter : 'custom(url(shaders/detached_tiles.vs) mix(url(shaders/detached_tiles.fs) normal source-atop), 5 5 border-box detached, amount 75.0, t 0.0, transform rotateX(0deg) scale(0.9)) grayscale(0)',

	init : ->
		threeDTV.stepsCalcul();
		threeDTV.keyMove();
		threeDTV.factsEffect();
		threeDTV.windowResize();
		true

	stepsCalcul : ->
		divWidth = parseInt(threeDTV.area.css('width'))
		divHeight = parseInt(threeDTV.area.css('height'))
		threeDTV.HorStep = divWidth/(threeDTV.minHor+Math.abs(threeDTV.maxHor))
		threeDTV.VerStep = divHeight/(threeDTV.minVer+Math.abs(threeDTV.maxVer))
		threeDTV.mouseMove();
		true


	mouseMove : ->
		threeDTV.area.mousemove((e)->
			threeDTV.curentX = (threeDTV.minHor-((e.pageX-parseInt(threeDTV.areaPos.left))/threeDTV.HorStep)).toFixed(1)
			threeDTV.curentY = (threeDTV.minVer-((e.pageY-parseInt(threeDTV.areaPos.top))/threeDTV.VerStep)).toFixed(1)
			math = (Math.abs(threeDTV.curentX*0.01))+0.2
			num = Math.abs(threeDTV.curentY).toFixed(0)
			threeDTV.transform = 'rotateX('+threeDTV.curentY+'deg) rotateY('+threeDTV.curentX+'deg)'
			threeDTV.movingArea.css('-webkit-transform',threeDTV.transform)
			true
		)
		true

	keyMove : ->
        document.addEventListener('keydown', (e)->
        	switch e.which
                when 37 then threeDTV.yAngle -= 90
                when 38 then threeDTV.xAngle += 90
                when 39 then threeDTV.yAngle += 90
                when 40 then threeDTV.xAngle -= 90
        	threeDTV.movingArea.css('-webkit-transform',"rotateX("+threeDTV.xAngle+"deg) rotateY("+threeDTV.yAngle+"deg)");
        	true
        )
        true

    factsEffect : ->
    	facts = $('.fact');
    	facts.mouseover( ->
    		$(this).addClass('active')
    		true
    	)
    	true

    windowResize : ->
    	Win = $(window);
    	Win.resize(->
    		winHeight = Win.height()
    		winWidth = Win.width()

    		baseHeight = winHeight/100
    		baseWidth = winWidth/100

    		#calcul du ratio du cube // base = 1/3 de la largeur

    		cubWidthPx = baseWidth*33.33
    		cubHeightPercent = cubWidthPx/baseHeight

    		console.log cubHeightPercent
    		threeDTV.movingArea.css('height',cubHeightPercent+'%')

    		baseCubWidth = cubWidthPx/100
    		transZ350 = baseCubWidth*63.64
    		transZ180 = baseCubWidth*32.65
    		transZ100 = baseCubWidth*18.18

    		$('#cube .one').css('-webkit-transform','rotateX(90deg) translateZ('+transZ180+'px)')
    		$('#cube .two').css('-webkit-transform','translateZ('+transZ180+'px)')
    		$('#cube .three').css('-webkit-transform','rotateY(90deg) translateZ('+transZ350+'px)')
    		$('#cube .four').css('-webkit-transform','rotateY(180deg) translateZ('+transZ180+'px)')
    		$('#cube .five').css('-webkit-transform','rotateY(-90deg) translateZ('+transZ180+'px)')
    		$('#cube .six').css('-webkit-transform','rotateX(-90deg) translateZ('+transZ100+'px) rotate(180deg)')

    		true
    	)
    	true
#fin de l'objet
}
threeDTV.init();
