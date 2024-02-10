import {
  CallHandler,
  ExecutionContext,
  HttpException,
  Injectable,
  NestInterceptor,
  NotFoundException,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { EntityNotFoundError } from 'typeorm/error/EntityNotFoundError';

const errorOverridingStrategy = [
  {
    initial: EntityNotFoundError,
    target: NotFoundException,
  },
];

@Injectable()
export class ErrorsInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    return next.handle().pipe(
      catchError((error) => {
        errorOverridingStrategy.forEach(({ initial, target }) => {
          if (error instanceof initial) {
            throw new target(error.message);
          }
        });
        throw error;
      }),
    );
  }
}
