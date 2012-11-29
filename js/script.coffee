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
    		console.log 'lol'
    		$(this).addClass('active')
    		true
    	)
    	true
#fin de l'objet
}
threeDTV.init();
