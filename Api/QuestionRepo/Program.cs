﻿using Microsoft.EntityFrameworkCore;
using QuestionRepo.Business.AnimalBusiness;
using QuestionRepo.Business.PlantBusiness;
using QuestionRepo.Business.ItemBusiness;
using QuestionRepo.Business.QuestionBusiness;
using QuestionRepo.Business.RecordBusiness;
using QuestionRepo.Business.UserBusiness;
using QuestionRepo.Models;
using QuestionRepo.Repositories.AnimalRepositories;
using QuestionRepo.Repositories.ItemRepositories;
using QuestionRepo.Repositories.QuestionRepositories;
using QuestionRepo.Repositories.RecordRepositories;
using QuestionRepo.Repositories.UserRepositories;
using QuestionRepo.Repositories.PlantRepositories;

namespace QuestionRepo
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);
            var connectionString = builder.Configuration.GetConnectionString("DefaultConnectionStringDB");
            builder.Services.AddDbContext<QuestionWarehouseContext>(options => options.UseSqlServer(connectionString));
            builder.Services.AddScoped<IQuestionRepository, QuestionRepository>();
            builder.Services.AddScoped<IQuestionService, QuestionService>();

            builder.Services.AddScoped<IUserRepository, UserRepository>();
            builder.Services.AddScoped<IUserService, UserService>();

            builder.Services.AddScoped<IRecordRepository, RecordRepository>();
            builder.Services.AddScoped<IRecordService, RecordService>();

            builder.Services.AddScoped<IItemRepository, ItemRepository>();
            builder.Services.AddScoped<IItemService, ItemService>();

            builder.Services.AddScoped<IAnimalRepository, AnimalRepository>();
            builder.Services.AddScoped<IAnimalService, AnimalService>();

            builder.Services.AddScoped<IPlantRepository, PlantRepository>();
            builder.Services.AddScoped<IPlantService, PlantService>();

            // Add services to the container.

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseAuthorization();

            app.MapControllers();

            app.Run();
        }
    }
}
