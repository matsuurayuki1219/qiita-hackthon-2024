import { Module } from '@nestjs/common';
import { UsersController } from './controllers/users/users.controller';
import { UserService } from './services/user/user.service';
import { UserModule } from './modules/user/user.module';
import { AuthService } from './services/auth/auth.service';
import { AuthModule } from './modules/auth/auth.module';
import { PraiseService } from './services/praise/praise.service';
import { PrisesController } from './controllers/praise/praise.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfigService } from './services/database-config/database-config.service';

@Module({
  imports: [
    UserModule,
    AuthModule,
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: 'localhost',
      port: 5432,
      username: 'root',
      password: 'h9XG|"I4N<k<LBy]',
      database: 'qiita',
    }),
  ],
  controllers: [UsersController, PrisesController],
  providers: [UserService, AuthService, PraiseService, DatabaseConfigService],
})
export class AppModule {}
