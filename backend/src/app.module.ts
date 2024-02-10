import { Module } from '@nestjs/common';
import { UsersController } from './controllers/users/users.controller';
import { UserService } from './services/user/user.service';
import { UserModule } from './modules/user/user.module';
import { AuthService } from './services/auth/auth.service';
import { AuthModule } from './modules/auth/auth.module';
import { PraiseService } from './services/praise/praise.service';
import { PrisesController } from './controllers/praise/praise.controller';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfigService } from './services/database-config/database-config.service';

@Module({
  imports: [
    UserModule,
    AuthModule,
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useClass: DatabaseConfigService,
    }),
  ],
  controllers: [UsersController, PrisesController],
  providers: [UserService, AuthService, PraiseService],
})
export class AppModule {}
