class MyMiddleware
	def initialize(app)
		@app = app
	end

	def call(env)
		puts "my middleware before!!!"
		ret = @app.call(env)
		puts "my middleware after!!!"
		ret
	end
end